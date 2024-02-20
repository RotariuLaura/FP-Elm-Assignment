module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, id, href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


contactView : String -> DetailWithName -> Html msg
contactView theClass contact =
     div [ class theClass]
     [ text contact.name
     , text " - "
     , text contact.detail
     ]


socialView : String -> DetailWithName -> Html msg
socialView theClass social =
     div [class theClass]
     [ a [ href social.detail] [text social.name]
     ]


view : PersonalDetails -> Html msg
view details = 
     div [] 
         [ h1 [class "name", id "name"] [text details.name]
         , em [class "intro", id "intro"] [text details.intro]
         , div [class "contacts"] (List.map(\contact -> contactView "contact-detail" contact) details.contacts)
         , div [class "socials"] (List.map(\social -> socialView "social-link" social) details.socials)
         ]