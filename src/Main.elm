module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (attribute)
import Html.Events exposing (onClick)
import Json.Encode as E


main : Program () ChartModel Msg
main =
    Browser.element
        { init = \_ -> ( init (), Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias ChartModel =
    { xAxis : { categories : List String }
    , series : List { data : List Float }
    }


init _ =
    ChartModel { categories = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ] } [ { data = [ 29.9, 71.5, 106.4, 129.2, 144, 176, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4 ] } ]


type Msg
    = Double


update msg mdl =
    ( { mdl | series = List.map doubleSeries mdl.series }, Cmd.none )


doubleSeries d =
    { d | data = List.map (\x -> x * 2) d.data }


view : ChartModel -> Html Msg
view mdl =
    div []
        [ button [ onClick Double ] [ text "Double!" ]
        , node "my-chart" [ attribute "chartsettings" (E.encode 0 (encodeChartModel mdl)) ] []
        ]


encodeChartModel : ChartModel -> E.Value
encodeChartModel mdl =
    E.object
        [ ( "xAxis", encodeXAxis mdl.xAxis )
        , ( "series", encodeSeries mdl.series )
        ]


encodeXAxis x =
    E.object [ ( "categories", E.list E.string x.categories ) ]


encodeSeries s =
    E.list encodeSeriesData s


encodeSeriesData d =
    E.object [ ( "data", E.list E.float d.data ) ]
