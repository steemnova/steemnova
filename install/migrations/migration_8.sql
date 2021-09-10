alter table `%PREFIX%planets`
    add `coins` float default 0.0 null;

alter table `%PREFIX%users`
    add `coins` float default 0.0 null;

create table `%PREFIX%coinpot`
(
    id int auto_increment,
    next_payout int null,
    is_active bool null,
    amount float null,
    time_paid int null,
    universe_id int null,

    constraint %PREFIX%coinpot_pk
        primary key (id)
);

alter table %PREFIX%config
    add coinpot_start int default 1000 null;

alter table %PREFIX%config
    add coinpot_increase int default 80 null;

alter table %PREFIX%config
    add referral_earn float default 0.05 null;

alter table %PREFIX%config
    add coinpot_wait_minutes int default 240 null;

alter table %PREFIX%config
    add coinpot_random_minutes int default 60 null;

alter table %PREFIX%users
    add ref_coins float default 0.0 null;

alter table %PREFIX%users
    add type_npc int default 0 null;

alter table %PREFIX%users
    add coins_username varchar(100) null;

alter table %PREFIX%users
    add avatar_url varchar(255) null;



