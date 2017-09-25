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
        pixelSize = model.pixelSize
        gridWidth = pixelSize * model.width
        gridHeight = pixelSize * model.height
        gridCount = model.width * model.height

        pixels = Pixel "#C82D2D" pixelSize
            |> pixelCloner model.width model.pixelSize
            |> List.concatMap (
                pixelCloner model.height model.pixelSize
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

pixelCloner numClones pixelSize pixel =
    List.repeat numClones pixel
    |> List.indexedMap (\i p ->
        p (pixelSize * i)
    )

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
