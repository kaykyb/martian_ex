defmodule MartianExTest do
  use ExUnit.Case
  doctest MartianEx

  alias MartianEx
  alias MartianEx.Notion.Common
  alias MartianEx.Notion.Blocks

  @md_files ~w(complex-items images large-item list math table)

  setup_all do
    fixtures = load_md_fixtures!()
    {:ok, fixtures: fixtures}
  end

  describe "markdown_to_blocks" do
    test "should convert markdown to blocks" do
      text = """
      hello _world_
      ***
      ## heading2
      * [x] todo
      """

      assert {:ok,
              [
                Blocks.paragraph([
                  Common.rich_text("hello "),
                  Common.rich_text("world", italic: true)
                ]),
                Blocks.heading_two([Common.rich_text("heading2")]),
                Blocks.to_do(true, [Common.rich_text("todo")], [])
              ]} == MartianEx.markdown_to_blocks(text)
    end

    test "should render code using plain text by default" do
      text = """
      ## Code
      ```
      const hello = "hello"
      ```
      """

      assert {:ok,
              [
                Blocks.heading_two([Common.rich_text("Code")]),
                Blocks.code([Common.rich_text("const hello = \"hello\"")], "plain text")
              ]} == MartianEx.markdown_to_blocks(text)
    end

    test "should render code using language keys" do
      text = """
      ## Code
      ``` webassembly
      const hello = "hello";
      ```
      """

      assert {:ok,
              [
                Blocks.heading_two([Common.rich_text("Code")]),
                Blocks.code([Common.rich_text("const hello = \"hello\";")], "webassembly")
              ]} == MartianEx.markdown_to_blocks(text)
    end

    test "should render complex items", state do
      text = state[:fixtures]["complex-items"]

      assert {:ok,
              [
                Blocks.heading_one([Common.rich_text("Images")]),
                Blocks.paragraph([Common.rich_text("This is a paragraph!")]),
                Blocks.blockquote([], [Blocks.paragraph([Common.rich_text("Quote")])]),
                Blocks.paragraph([Common.rich_text("Paragraph")]),
                Blocks.image("https://url.com/image.jpg")
              ]} == MartianEx.markdown_to_blocks(text)
    end

    # TODO: Should breakup large elements

    test "should render lists", state do
      text = state[:fixtures]["list"]

      assert {:ok,
              [
                Blocks.heading_one([Common.rich_text("List")]),
                Blocks.bulleted_list_item(
                  [Common.rich_text("Item 1")],
                  [Blocks.bulleted_list_item([Common.rich_text("Sub Item 1")], [])]
                ),
                Blocks.bulleted_list_item([Common.rich_text("Item 2")], [])
              ]} == MartianEx.markdown_to_blocks(text)
    end

    test "should render tables", state do
      text = state[:fixtures]["table"]

      assert {:ok,
              [
                Blocks.heading_one([Common.rich_text("Table")]),
                Blocks.table(
                  [
                    Blocks.table_row([
                      [Common.rich_text("First Header")],
                      [Common.rich_text("Second Header")]
                    ]),
                    Blocks.table_row([
                      [Common.rich_text("Content Cell")],
                      [Common.rich_text("Content Cell")]
                    ]),
                    Blocks.table_row([
                      [Common.rich_text("Content Cell")],
                      [Common.rich_text("Content Cell")]
                    ])
                  ],
                  2
                )
              ]} == MartianEx.markdown_to_blocks(text)
    end

    test "should render images", state do
      text = state[:fixtures]["images"]

      assert {:ok,
              [
                Blocks.heading_one([Common.rich_text("Images")]),
                Blocks.paragraph([
                  Common.rich_text("This is an image in a paragraph "),
                  Common.rich_text(", which isnt supported in Notion.")
                ]),
                Blocks.image("https://image.com/url.jpg"),
                Blocks.image("https://image.com/paragraph.jpg"),
                Blocks.image("https://image.com/blah")
              ]} == MartianEx.markdown_to_blocks(text)
    end

    # TODO: Should parse math
  end

  defp load_md_fixtures!() do
    @md_files
    |> Enum.map(fn file_name ->
      content = File.read!("test/fixtures/#{file_name}.md")

      {file_name, content}
    end)
    |> Map.new()
  end
end
