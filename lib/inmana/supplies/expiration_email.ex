defmodule Inmana.Supplies.ExpirationEmail do
  import Bamboo.Email

  alias Inmana.Supply

  def create(to_email, supplies) do
    new_email(
      to: to_email,
      from: "app@inmana.com",
      subject: "Supplies that are about to expire",
      html_body: email_html(supplies),
      text_body: email_text(supplies)
    )
  end

  defp email_text(supplies) do
    initial_text = "-------- Supplies that are about to expire --------\n"

    Enum.reduce(supplies, initial_text, fn supply, text -> text <> supply_text(supply) end)
  end

  defp supply_text(%Supply{
         description: description,
         expiration_date: expiration_date,
         responsable: responsable
       }) do
    "Description: #{description}, Expiration Date: #{expiration_date}, Responsable: #{responsable}\n"
  end

  defp email_html(supplies) do
    initial_html =
      "<h2>Supplies that are about to expire</h2><table><tr><th>Description</th><th>Expiration Data</th><th>Responsable</th></tr>"

    Enum.reduce(supplies, initial_html, fn supply, text -> text <> supply_html(supply) end) <>
      "</table>"
  end

  defp supply_html(%Supply{
         description: description,
         expiration_date: expiration_date,
         responsable: responsable
       }) do
    "<tr><td>#{description}</td><td>#{expiration_date}</td><td>#{responsable}</td></tr>"
  end
end
