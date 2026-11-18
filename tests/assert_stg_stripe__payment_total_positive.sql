-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail.
select
    order_id,
    sum(amount) as total_amount
from {{ ref('stg_stripe__payments') }}
group by 1
having total_amount < 0

-- remember: the goal is to return (aggregated) rows which violate the assertion
-- in this case, if the total_amount is negative, thus violating the assertion that the toal_amount is positive, we return a row to indicate tha the test failed 