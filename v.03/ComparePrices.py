#!/usr/bin/env python
# -*- coding: utf-8 -*-

class ComparePrices:
    """
    Custom library to demonstrate features from Robot Framework
    """
    def compare_prices_against(self, price, compared_price):
        """
        Format and compare values return if price is lower the compared_price
        """
        if price == '-':
            return False
        price = price.replace('R$ ', '')
        price = int(price)
        if price < int(compared_price):
            return True
        else:
            return False
