module Views exposing (..)

import Html exposing (Html, div)
import Svg exposing (..)
import Svg.Attributes as Att

import Models exposing (Model)

import Debug

gridSize = 120


type alias Pixel =
    { stroke : String
    , size : Int
    , x : Int
    , y : Int
    }

view : Model -> Html msg
view model =
    let
        gridWidth = gridSize * model.width
        gridHeight = gridSize * model.height
        gridCount = model.width * model.height

        pixels = Pixel "#C82D2D" gridSize
            |> List.repeat model.width
            |> List.indexedMap (\i pixel ->
                pixel (positionFinder gridWidth model.width i)
                |> List.repeat model.height
                |> List.indexedMap
                (\j row ->
                    row (positionFinder gridHeight model.height j)
                )
            )
        |> Debug.log "start"


    in
        div []
            [
                svg [ Att.width (toString gridWidth)
                    , Att.height (toString gridHeight)
                    , Att.viewBox <| "0 0 " ++ (toString gridWidth) ++ " " ++ (toString gridHeight)
                    ]
                [ svgPixel 0 0 gridSize gridSize
                , svgPixel 120 120 gridSize gridSize
                ]
            ]

positionFinder : Int -> Int -> Int -> Int
positionFinder totalSize numDivisions index =
    (totalSize * (index)) // numDivisions

svgPixel : Int -> Int -> Int -> Int -> Html.Html msg
svgPixel x y width height =
    rect
    [ Att.x (toString x)
    , Att.y (toString y)
    , Att.width (toString width)
    , Att.height (toString height)
    , Att.stroke "#C82D2D"
    , Att.strokeWidth "4"
    ] []
