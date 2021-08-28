function fleetCountDown() {
    $('.fleets').each(function () {
        var s = $(this).data('fleet-time') - (serverTime.getTime() - startTime) / 1000;
        if (s <= 0) {
            $(this).text('-');
        } else {
            $(this).text(GetRestTimeFormat(s));
        }
    })
    window.setTimeout(fleetCountDown, 1000);
}

function timeCountDown() {
    $('.timer').each(function () {
        var s = $(this).data('time') - (serverTime.getTime() - startTime) / 1000;
        if (s <= 0) {
            window.location.href = "game.php?page=overview";
        } else {
            $(this).text(GetRestTimeFormat(s));
        }
    });
    window.setTimeout(timeCountDown, 1000);
}

$(document).ready(function () {
    window.setTimeout(function () {
        fleetCountDown();
        timeCountDown();
    }, 1000);
});
