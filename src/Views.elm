module Views exposing (..)

import Html exposing (Html, div)
import Svg exposing (..)
import Svg.Attributes as Att

import Models exposing (Model)

import Debug

type alias Pixel =
    { stroke : String
    , size : Int
    , x : Int
    , y : Int
    }

view : Model -> Html msg
view model =
    let
        gridSize = model.pixelSize
        gridWidth = gridSize * model.width
        gridHeight = gridSize * model.height
        gridCount = model.width * model.height

        pixels = Pixel "#C82D2D" gridSize
            |> List.repeat model.width
            |> List.indexedMap (\i pixel ->
                pixel (positionFinder gridWidth model.width i)
            )
            |> List.concatMap (\pixel ->
                List.repeat model.height pixel
                |> List.indexedMap
                (\j row ->
                    row (positionFinder gridHeight model.height j)
                )
            )

        svgPixels = List.map (\p ->
            svgPixel p.x p.y p.size p.size
        ) pixels

    in
        div []
            [
                svg [ Att.width (toString gridWidth)
                    , Att.height (toString gridHeight)
                    , Att.viewBox <| "0 0 " ++ (toString gridWidth) ++ " " ++ (toString gridHeight)
                    ]
                svgPixels
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
