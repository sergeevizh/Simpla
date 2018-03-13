<?php

function smarty_function_get_new_products($params, &$smarty)
{
    if (!isset($params['visible'])) {
        $params['visible'] = 1;
    }
    if (!isset($params['sort'])) {
        $params['sort'] = 'created';
    }
    if (!empty($params['var'])) {

        require_once('./api/Simpla.php');
        $simpla = new Simpla();

        $products = $simpla->products->get_products_compile($params);

        $smarty->assign($params['var'], $products);
    }
}