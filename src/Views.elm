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

        arg = Debug.log "start" <|
            List.indexedMap
            (\i row ->
                List.indexedMap (\j p ->
                    p (pixelXFinder gridWidth model.width j)
                ) row
            ) <|
            List.repeat 4 <|
            List.indexedMap
            (\i pixel -> pixel (pixelXFinder gridWidth model.width i)) <|
            List.repeat 4 <|
            Pixel "#C82D2D" 120

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

pixelXFinder : Int -> Int -> Int -> Int
pixelXFinder width numCols index =
    (width * (index)) // numCols

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
