module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)
import Html.Attributes exposing (href)
import Model.Date exposing (Month(..))


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
    events |> List.sortWith (\event1 event2 ->
        Interval.compare event1.interval event2.interval)

viewUrl : Maybe String -> Html Never
viewUrl maybeUrl =
    case maybeUrl of
        Just url ->  a [ href url ] [ text url ]
        Nothing -> text "-"

view : Event -> Html Never
view event =
     div [ classList[("event", True), ("event-important", event.important)]
         ]
         [ div [class "event-title"] [text event.title]
         , div [class "event-description"] [event.description]
         , div [class "event-interval"] [Interval.view event.interval]
         , div [class "event-category"] [categoryView event.category]
         , div [class "event-url"] [viewUrl event.url]
         ]

