module Main exposing (..)

import Models exposing (Model, Msg(..))
import Views exposing (view)
import Html exposing (Html)


-- MODEL


init : Model
init =
    { width = 100, height = 100, pixelSize = 5, activatedPixels = [], radius = 2 }



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeSize stringSize ->
            let
                radius =
                    Result.withDefault 2 <| String.toInt stringSize
            in
                { model | radius = radius }

        Circle ->
            let
                allPixels =
                    List.repeat model.height 0
                        |> List.indexedMap
                            (\i _ ->
                                List.repeat model.width 0
                                    |> List.indexedMap (\j _ -> ( i, j ))
                            )
                        |> List.concat

                ( cx, cy ) =
                    ( model.width // 2, model.height // 2 )

                radius =
                    model.radius

                circle =
                    List.filter (\( x, y ) -> (x - cx) * (x - cx) + (y - cy) * (y - cy) <= radius * radius)
                        allPixels
            in
                { model | activatedPixels = circle }

        Touch x y ->
            if List.member ( x, y ) model.activatedPixels then
                { model
                    | activatedPixels =
                        List.filter
                            (\position -> position /= ( x, y ))
                            model.activatedPixels
                }
            else
                { model | activatedPixels = ( x, y ) :: model.activatedPixels }



-- MAIN


main =
    Html.beginnerProgram { model = init, view = view, update = update }
