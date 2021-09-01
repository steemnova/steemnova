{if $own_ally}
    <div class="alert alert-warning ally-attack">{$LNG.attack_own_ally}</div>
{/if}
{foreach $MissionSelector as $MissionID}
    <div class="form-check">
        <input type="radio" value="{$MissionID}" class="form-check-input" name="mission"
               id="radio_{$MissionID}" autocomplete="off"
               {if $mission == $MissionID || $MissionID@total == 1}checked="checked"{/if}>
        <label class="form-check-label"
               for="radio_{$MissionID}">{$LNG["type_mission_{$MissionID}"]}</label>
        {if $MissionID == 17}
            <div class="p-1 alert alert-warning">{$LNG.fl_transfer_alert_message}</div>{/if}
        {if $MissionID == 15}
            <div class="alert alert-warning">{$LNG.fl_expedition_alert_message}</div>{/if}
        {if $MissionID == 11}
            <div class="alert alert-warning">{$LNG.fl_dm_alert_message}</div>{/if}
        {if $MissionID == 7}
            {if $max_planet_exceeded}
                <div class="alert alert-warning">{sprintf($LNG.fl_colonize_alert_message, $min_astro_level)}</div>
            {/if}
            {if $colonize_notech}
                <div class="alert alert-danger">{sprintf($LNG.fl_colonize_alert_message_tech, $min_astro_level)}</div>
            {/if}
        {/if}
    </div>
{/foreach}
<hr/>
{if $StaySelector}
    <label for="id-stay" class="form-label">{$LNG.fl_hold_time}</label>
    {html_options name=staytime options=$StaySelector id="id-stay"} {$LNG.fl_hours}
{/if}
    <input value="{$LNG.fl_continue}" type="submit" class="btn btn-primary"/>