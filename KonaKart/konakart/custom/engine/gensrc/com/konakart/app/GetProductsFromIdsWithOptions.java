package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - GetProductsFromIdsWithOptions - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class GetProductsFromIdsWithOptions
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public GetProductsFromIdsWithOptions(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public ProductIf[] getProductsFromIdsWithOptions(String sessionId, DataDescriptorIf dataDesc, int[] prodIdArray, int languageId, FetchProductOptionsIf options) throws KKException
     {
         return kkEng.getProductsFromIdsWithOptions(sessionId, dataDesc, prodIdArray, languageId, options);
     }
}