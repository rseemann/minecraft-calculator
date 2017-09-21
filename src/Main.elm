import Models exposing (Model)
import Views exposing (view)

import Html exposing (Html)

-- MODEL

init : Model
init =
    { width = 20, height = 40, pixelSize = 10 }

-- UPDATE

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  model


-- MAIN

main =
  Html.beginnerProgram { model = init, view = view, update = update }
