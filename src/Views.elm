module Views exposing (..)

import Html exposing (Html, div, button)
import Html.Attributes as HA
import Html.Events as HE
import Svg exposing (..)
import Svg.Events as SE
import Svg.Attributes as Att
import Models exposing (Model, Msg(..))


viewPixel : Int -> Int -> Int -> List ( Int, Int ) -> Svg Msg
viewPixel x y size activated =
    let
        color =
            if List.member ( x, y ) activated then
                "#00ff00"
            else
                "#ff0000"
    in
        rect
            [ Att.x (toString <| size * x)
            , Att.y (toString <| size * y)
            , Att.width (toString size)
            , Att.height (toString size)
            , Att.fill color
            , Att.stroke "#000000"
            , Att.strokeWidth "1"
            , SE.onClick <| Touch x y
            ]
            []


viewPixels : Int -> Int -> Int -> List ( Int, Int ) -> List (Svg Msg)
viewPixels boardWidth boardHeight pixelSize activatedPixels =
    List.repeat boardHeight 0
        |> List.indexedMap
            (\i _ ->
                List.repeat boardWidth 0
                    |> List.indexedMap (\j _ -> viewPixel j i pixelSize activatedPixels)
            )
        |> List.concat


view : Model -> Html Msg
view model =
    let
        pixelSize =
            model.pixelSize

        gridWidth =
            pixelSize * model.width

        gridHeight =
            pixelSize * model.height
    in
        div []
            [ svg
                [ Att.width (toString gridWidth)
                , Att.height (toString gridHeight)
                , Att.viewBox <| "0 0 " ++ (toString gridWidth) ++ " " ++ (toString gridHeight)
                ]
                (viewPixels
                    model.width
                    model.height
                    model.pixelSize
                    model.activatedPixels
                )
            , div []
                [ Html.input [ HE.onInput ChangeSize ]
                    []
                , button
                    [ HE.onClick Circle ]
                    [ Html.text "Circle :)"
                    ]
                ]
            ]
