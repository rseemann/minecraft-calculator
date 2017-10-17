module Models exposing (..)


type alias Model =
    { width : Int
    , height : Int
    , pixelSize : Int
    , activatedPixels : List ( Int, Int )
    , radius : Int
    }


type Msg
    = Touch Int Int
    | Circle
    | ChangeSize String
