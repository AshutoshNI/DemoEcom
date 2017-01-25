package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - SearchForSubscriptionsPerCustomer - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class SearchForSubscriptionsPerCustomer
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public SearchForSubscriptionsPerCustomer(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public SubscriptionsIf searchForSubscriptionsPerCustomer(String sessionId, DataDescriptorIf dataDesc, SubscriptionSearchIf subscriptionSearch) throws KKException
     {
         return kkEng.searchForSubscriptionsPerCustomer(sessionId, dataDesc, subscriptionSearch);
     }
}