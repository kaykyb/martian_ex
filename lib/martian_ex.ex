defmodule MartianEx do
  @moduledoc """
  `MartianEx` is an adaptation of the JavaScript library
  [@tryfabric/martian](https://github.com/tryfabric/martian).

  Just like the original library, MartianEx aims at processing markdown content
  to Notion API block format.

  MartianEx uses Earmark to create a Markdown AST, which is then converted into
  Notion API block objects.

  ## Supported Markdown Elements
  - Inline Rich Text elements
  - Lists
  - Headers, down to h3
  - Code blocks, including language highlithing
  - Block quotes
  - Tables
  - Block images
    - Inline images are ignored
  """

  @doc """
  Converts a Markdown content to Notion block objects

  ## Examples

      iex> MartianEx.markdown_to_blocks("## heading2\\n [x] todo\\n")
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
  """
  @spec markdown_to_blocks(String.t()) :: {:ok, list()} | {:error, any(), any()}
  def markdown_to_blocks(body) do
    with {:ok, ast, _} <- Earmark.Parser.as_ast(body) do
      blocks = MartianEx.Parser.parse_blocks(ast)
      {:ok, blocks}
    end
  end
end
