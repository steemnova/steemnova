{block name="title" prepend}{$LNG.lm_logout}{/block}
{block name="content"}
    <div class="alert alert-info">
        <strong>{$LNG.lo_title}</strong>
        <p>{$LNG.lo_logout}</p>
        <p>{$LNG.lo_redirect}<br/>
            {$LNG.lo_notify}<br/>
            <a href="./index.php">{$LNG.lo_continue}</a>
        </p>
    </div>
{/block}
{block name="script" append}
    <script type="text/javascript">
        var second = 5;

        function Countdown() {
            if (second == 0)
                return;

            second--;
            $('#seconds').text(second);
            window.setTimeout(Countdown, 1000);

        }

        window.setTimeout(function () {window.location.href='./index.php'; }, 5000);
        window.setTimeout(Countdown, 1000);
    </script>
{/block}