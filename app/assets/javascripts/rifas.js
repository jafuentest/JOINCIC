var iniciado = false;
var running = false;
var slowDown = false;
var initDelay = 100;
var delay = initDelay;
var index = 0;
var participants;
var raffle;
var testdata;

function setRaffleTypeListener() {
    $('#rifa').on('change', function(event){
        var rifa = $(this);
        if (rifa.val() != '' && rifa.val() != null) {
            $.ajax({
                url: '/rifas/getParticipantes.json',
                type: 'POST',
                dataType: 'json',
                data: {
                    rifa : rifa.val()
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    smoke.alert('Ocurrió un error!:\n' + errorThrown);
                },
                success: function(data, textStatus, jqXHR) {
                    participants = data.participantes;
                    raffle = data.rifa;
                    iniciado = true;
                    $('#roulette_button').removeAttr('disabled');
                }
            })
        }
    });
}

function setRouletteListener(){
    $('#roulette_button').on('click', function(event){
        event.preventDefault();
        if (iniciado) {
            if (!running) {
                running = true;
                $('#roulette_button').val('Parar!');
                initRoulette(participants);
            } else {
                running = false;
                $('#roulette_button').attr("disabled", "disabled");
                $('#roulette_button').val('Iniciar!');
            }
        } else {

        }
    });
}

function setListeners() {
    setRaffleTypeListener();
    setRouletteListener();
}

function initRoulette(people){
    window.setTimeout(function(){
        //Si se ha presiendo el boton de parar
        //convirtiendo @stop_it en true, se selecciona
        // el ganador y se cierra el sorteo
        if(!running){
            if (delay > 700) {
                slowDown = true;
            }
            if (!slowDown) {
                delay += 100;
            } else {
                //var casilla_ganadora = Math.floor(Math.random()*people.length);
                //var ganador          = people[casilla_ganadora];
                //$("#concursante").text("");
                winner = people[index];
                var winnerstr = winner.nombre+' '+winner.apellido+ ' - ' + winner.cedula;
                $("#winner").val(winnerstr);
                smoke.confirm("El ganador es "+ winnerstr + '\n Marcar a este usuario como ganador?', function(e){
                    if (e) {
                        $.ajax({
                            url: '/rifas/setWinner',
                            type: 'POST',
                            dataType: 'json',
                            data: {
                                winner : winner,
                                raffle : raffle
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                smoke.alert('Ocurrió un error!2:\n' + errorThrown);
                            },
                            success: function(data, textStatus, jqXHR) {
                                testdata = data[0];
                                if (testdata.error) {
                                    smoke.alert('Ha ocurrido un error3:\n'+testdata.error);
                                } else {
                                    smoke.alert('Ganador registrado con éxito!:\nNombre: '+data[0].winner.nombre+' '+data[0].winner.apellido+'\nCédula: ' + data[0].winner.cedula);
                                    if (testdata.raffleDone) {
                                        $('option[value="'+testdata.raffle.id+'"]').remove();
                                    }
                                }
                            },
                            complete: function() {
                                iniciado = false;
                                running = false;
                                slowDown = false;
                                initDelay = 100;
                                delay = initDelay;
                                index = 0;
                                participants = null;
                                raffle = null;
                                $('#winner').val('');
                                $('#rifa').val('');
                                $('#roulette_button').removeAttr('disabled');
                            }
                        });
                    } else {
                        $('#roulette_button').removeAttr('disabled');
                        $('#roulette_button').val('Parar!');
                        running = true;
                        slowDown = false;
                        delay = initDelay;
                        index = Math.floor(Math.random()*people.length);
                        initRoulette(people);
                    }
                });
                return false;
            }
        }
        $("#winner").val(people[index].nombre+' '+people[index].apellido+ ' - ' + people[index].cedula);
        //Elegir un siguiente posible ganador al random 
        index = Math.floor(Math.random()*people.length);
        initRoulette(people);
    },
    delay
    );
}

$(document).ready(function(){
    setListeners();
});
