# MartianEx

`MartianEx` is an adaptation of the JavaScript library [@tryfabric/martian](https://github.com/tryfabric/martian).

Just like the original library, MartianEx aims at processing markdown content to Notion API block format.

MartianEx uses Earmark to create a Markdown AST, which is then converted into Notion API block objects.

## Supported Markdown Elements

- Inline Rich Text elements
- Lists
- Headers, down to h3
- Code blocks, including language highlithing
- Block quotes
- Tables
- Block images
  - Inline images are ignored

## Installation

MartianEx is [available in Hex](https://hex.pm/packages/martian_ex), the package can be installed
by adding `martian_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:martian_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/martian_ex>.

## Usage

To convert a Markdown text to Notion API blocks, simply call `MartianEx.markdown_to_blocks`:

```elixir
  MartianEx.markdown_to_blocks("## heading2\\n [x] todo\\n")
```

This call will output the following `{:ok, blocks}` tuple:

```elixir
  {:ok, [
    %{
      type: "heading_2",
      object: "block",
      heading_2: %{
        rich_text: [
          %{
            type: "text",
            text: %{content: "heading2"},
            annotations: %{
              code: false,
              color: "default",
              italic: false,
              underline: false,
              bold: false,
              strikethrough: false
            }
          }
        ]
      }
    },
    %{
      type: "paragraph",
      paragraph: %{
        rich_text: [
          %{
            type: "text",
            text: %{content: " [x] todo"},
            annotations: %{
              code: false,
              color: "default",
              italic: false,
              underline: false,
              bold: false,
              strikethrough: false
            }
          }
        ]
      },
      object: "block"
    }
  ]}
```
