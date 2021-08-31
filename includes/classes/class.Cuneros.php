<?php

class Cuneros
{
    public static function claimCuneros($amount, $targetId = NULL, $refEarn = true)
    {
        global $USER;

        if ($targetId === NULL) {
            $USER['coins'] += $amount;

            if($refEarn) {
                self::claimRefCuneros($amount, NULL);
            }
         } else {
            $sql = 'UPDATE %%USERS%% SET coins = coins + :Amount WHERE id = :userId';
            Database::get()->update($sql, ['Amount' => $amount, 'userId' => $targetId]);

            self::claimRefCuneros($amount, $targetId);
        }
    }

    protected static function claimRefCuneros($amount, $targetId = NULL)
    {
        global $USER;
        $refEarn = Config::get()->referral_earn * $amount;
        if($refEarn <= 0) {
            return false;
        }

        if($targetId === NULL) {
            $sol_id = $USER['ref_id'];
            $USER['ref_coins'] += $refEarn;
        } else {
            $sql = 'SELECT ref_id FROM %%USERS%% WHERE id = :userId';
            $sol_id = Database::get()->selectSingle($sql, ['userId' => $targetId], 'ref_id');
            if($sol_id) {
                $sql = 'UPDATE %%USERS%% SET coins ref_coint = ref_coins + :Amount WHERE id = :userId';
                Database::get()->update($sql, ['Amount' => $refEarn, 'userId' => $targetId]);
            }
        }
        if ($refEarn > 0 && $sol_id != 0) { // user has werber
            Cuneros::claimCuneros($refEarn, $sol_id, false);
        }
    }
}