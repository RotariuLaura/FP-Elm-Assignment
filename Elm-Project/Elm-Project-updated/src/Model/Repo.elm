module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as De
import Model.Date exposing (Month(..))


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }

viewDescription : Maybe String -> Html msg
viewDescription maybeDescription =
    let
         description = Maybe.withDefault " " maybeDescription 
    in
         a [ href description ] [ text description ]

view : Repo -> Html msg
view repo =
     div [ class "repo"]
         [ div [class "repo-name"] [text repo.name]
         , div [class "repo-description"] [viewDescription repo.description]
         , div [class "repo-url"] [a [ href repo.url ] [ text repo.url ]]
         , div [class "repo-stars"] [text (String.fromInt repo.stars)]
         ]


sortByStars : List Repo -> List Repo
sortByStars repos =
    repos |> List.sortBy (\repo -> repo.stars)


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : De.Decoder Repo
decodeRepo =
     De.map5 Repo
        (De.at ["name"] De.string)
        (De.field "description" (De.maybe De.string))
        (De.field "html_url" De.string)
        (De.field "pushed_at" De.string)
        (De.field "stargazers_count" De.int)
