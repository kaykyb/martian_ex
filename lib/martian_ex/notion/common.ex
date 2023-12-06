defmodule MartianEx.Notion.Common do
  @default_annotations [
    bold: false,
    strikethrough: false,
    underline: false,
    italic: false,
    code: false,
    color: "default"
  ]

  def rich_text(content, annotations \\ [], options \\ []) do
    annotations = Keyword.merge(@default_annotations, annotations)
    type = Keyword.get(options, :type, :text)

    rich_text(content, type, annotations, options)
  end

  defp rich_text(content, :text, annotations, opts) do
    url = Keyword.get(opts, :url)

    %{
      type: "text",
      annotations: Map.new(annotations),
      text: rich_text_text(content, url)
    }
  end

  defp rich_text(content, :equation, annotations, _options) do
    %{
      type: "equation",
      annotations: Map.new(annotations),
      equation: %{
        expression: content
      }
    }
  end

  defp rich_text_text(content, "http" <> _ = url) do
    %{
      content: content,
      link: %{
        type: "url",
        url: url
      }
    }
  end

  defp rich_text_text(content, nil) do
    %{
      content: content
    }
  end
end
