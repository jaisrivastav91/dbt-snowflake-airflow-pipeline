-- macros are reusable for business logic being conusmed by multiple models

{% macro discounted_amount(extended_price, discount_percentage, scale = 2) %}
    (-1 * {{ extended_price }} * {{ discount_percentage }})::decimal(16, {{ scale }})
{% endmacro %}