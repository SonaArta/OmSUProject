package omsu.lib_omsu.controller;

import omsu.lib_omsu.order.Order;
import omsu.lib_omsu.order.OrderCollection;

public class OrderController {
    private static OrderCollection orders;

    public static void createOrder(Order order)
    {
        orders.put(order);
    }

    public static void deleteOrder(Order order)
    {
        orders.remove(order);
    }
}
