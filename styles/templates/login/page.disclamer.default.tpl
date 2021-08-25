{block name="title" prepend}{$LNG.siteTitleDisclamer}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title"><h2>{$LNG.siteTitleDisclamer}</h2>
            </div>
            <div class="card-body">

                <ul>
                    <li>{$LNG.disclamerLabelAddress} {$disclamerAddress}</li>
                    <li>{$LNG.disclamerLabelPhone} {$disclamerPhone}</li>
                    <li>{$LNG.disclamerLabelMail} <a href="mailto:{$disclamerMail}">{$disclamerMail}</a></li>
                </ul>
                <h3>{$LNG.disclamerLabelNotice}</h3>
                <p class="card-text">{$disclamerNotice}</p>
            </div>
        </div>
    </div>
{/block}