with source as (

    select * from {{ source('tickit', 'users') }}

),

renamed as (

    select
        userid as user_id,
        username,
        firstname as first_name,
        lastname as last_name,
        city,
        state,
        email,
        phone

    from source

)

select * from renamed