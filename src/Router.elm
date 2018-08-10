module Router exposing (..)

import UrlParser exposing (..)


---- Router ----


type Route
    = Home
    | Blog Int
    | User String


router : Parser (Route -> a) a
router =
    oneOf
        [ map Home top
        , map Blog (s "blog" </> int)
        , map User (s "user" </> string)
        ]
