package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - GetContent - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class GetContent
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public GetContent(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public ContentIf getContent(int contentId, int languageId) throws KKException
     {
         return kkEng.getContent(contentId, languageId);
     }
}
