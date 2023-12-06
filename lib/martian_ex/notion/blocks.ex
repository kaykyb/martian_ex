defmodule MartianEx.Notion.Blocks do
  def heading_one(rich_text) do
    %{
      object: "block",
      type: "heading_1",
      heading_1: %{
        rich_text: rich_text
      }
    }
  end

  def heading_two(rich_text) do
    %{
      object: "block",
      type: "heading_2",
      heading_2: %{
        rich_text: rich_text
      }
    }
  end

  def heading_three(rich_text) do
    %{
      object: "block",
      type: "heading_3",
      heading_3: %{
        rich_text: rich_text
      }
    }
  end

  def paragraph(rich_text) do
    %{
      object: "block",
      type: "paragraph",
      paragraph: %{
        rich_text: rich_text
      }
    }
  end

  def image(url) do
    %{
      object: "block",
      type: "image",
      image: %{
        type: "external",
        external: %{
          url: url
        }
      }
    }
  end

  def code(rich_text, lang) do
    %{
      object: "block",
      type: "code",
      code: %{
        rich_text: rich_text,
        language: lang
      }
    }
  end

  def blockquote(rich_text, children) do
    %{
      object: "block",
      type: "quote",
      quote: %{
        rich_text: rich_text,
        children: children
      }
    }
  end

  def table_of_contents() do
    %{
      object: "block",
      type: "table_of_contents",
      table_of_contents: %{}
    }
  end

  def bulleted_list_item(rich_text, children) do
    %{
      object: "block",
      type: "bulleted_list_item",
      bulleted_list_item: %{
        rich_text: rich_text,
        children: children
      }
    }
  end

  def numbered_list_item(rich_text, children) do
    %{
      object: "block",
      type: "numbered_list_item",
      numbered_list_item: %{
        rich_text: rich_text,
        children: children
      }
    }
  end

  def to_do(checked, rich_text, children) do
    %{
      object: "block",
      type: "to_do",
      to_do: %{
        rich_text: rich_text,
        checked: checked,
        children: children
      }
    }
  end

  def table(children, table_width) do
    %{
      object: "block",
      type: "table",
      table: %{
        table_width: table_width,
        has_column_header: true,
        children: children
      }
    }
  end

  def table_row(cells) do
    %{
      object: "block",
      type: "table_row",
      table_row: %{
        cells: cells
      }
    }
  end

  def equation(value) do
    %{
      type: "equation",
      equation: %{
        expression: value
      }
    }
  end
end
