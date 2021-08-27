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

