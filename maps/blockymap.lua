return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 15,
  height = 10,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 3,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      class = "",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 9,
      image = "tileset.png",
      imagewidth = 576,
      imageheight = 384,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      wangsets = {},
      tilecount = 54,
      tiles = {}
    },
    {
      name = "tetris",
      firstgid = 55,
      class = "",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "Single Blocks/Blue.png",
      imagewidth = 64,
      imageheight = 64,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      wangsets = {},
      tilecount = 1,
      tiles = {}
    },
    {
      name = "tetris",
      firstgid = 56,
      class = "",
      tilewidth = 768,
      tileheight = 1408,
      spacing = 0,
      margin = 0,
      columns = 0,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 1,
        height = 1
      },
      properties = {},
      wangsets = {},
      tilecount = 18,
      tiles = {
        {
          id = 0,
          image = "Single Blocks/Blue.png",
          width = 64,
          height = 64
        },
        {
          id = 1,
          image = "Single Blocks/Green.png",
          width = 64,
          height = 64
        },
        {
          id = 2,
          image = "Single Blocks/LightBlue.png",
          width = 64,
          height = 64
        },
        {
          id = 3,
          image = "Single Blocks/Orange.png",
          width = 64,
          height = 64
        },
        {
          id = 4,
          image = "Single Blocks/Purple.png",
          width = 64,
          height = 64
        },
        {
          id = 5,
          image = "Single Blocks/Red.png",
          width = 64,
          height = 64
        },
        {
          id = 6,
          image = "Single Blocks/Yellow.png",
          width = 64,
          height = 64
        },
        {
          id = 7,
          image = "Shape Blocks/I.png",
          width = 64,
          height = 256
        },
        {
          id = 8,
          image = "Shape Blocks/J.png",
          width = 192,
          height = 128
        },
        {
          id = 9,
          image = "Shape Blocks/L.png",
          width = 192,
          height = 128
        },
        {
          id = 10,
          image = "Shape Blocks/O.png",
          width = 128,
          height = 128
        },
        {
          id = 11,
          image = "Shape Blocks/S.png",
          width = 192,
          height = 128
        },
        {
          id = 12,
          image = "Shape Blocks/T.png",
          width = 192,
          height = 128
        },
        {
          id = 13,
          image = "Shape Blocks/Z.png",
          width = 192,
          height = 128
        },
        {
          id = 14,
          image = "Board/BG_1.png",
          width = 64,
          height = 64
        },
        {
          id = 15,
          image = "Board/BG_2.png",
          width = 64,
          height = 64
        },
        {
          id = 16,
          image = "Board/Board.png",
          width = 768,
          height = 1408
        },
        {
          id = 17,
          image = "Board/Border.png",
          width = 64,
          height = 64
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 15,
      height = 10,
      id = 1,
      name = "Tile Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3,
        10, 11, 11, 58, 58, 58, 58, 58, 58, 58, 58, 58, 11, 11, 12,
        10, 11, 11, 58, 70, 70, 70, 70, 70, 70, 70, 58, 11, 11, 12,
        10, 11, 11, 58, 70, 70, 70, 70, 70, 70, 70, 58, 11, 11, 12,
        10, 11, 11, 58, 70, 70, 70, 70, 70, 70, 70, 58, 11, 11, 12,
        10, 11, 11, 58, 70, 70, 70, 70, 70, 70, 70, 58, 11, 11, 12,
        10, 11, 11, 58, 70, 70, 70, 70, 70, 70, 70, 58, 11, 11, 12,
        10, 11, 11, 58, 70, 70, 70, 70, 70, 70, 70, 58, 11, 11, 12,
        10, 11, 11, 58, 70, 70, 70, 70, 70, 70, 70, 58, 11, 11, 12,
        19, 20, 20, 58, 58, 58, 58, 58, 58, 58, 58, 58, 20, 20, 21
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 15,
      height = 10,
      id = 2,
      name = "Tile Layer 2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        33, 34, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        42, 43, 44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        51, 52, 53, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 31, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0,
        0, 0, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
