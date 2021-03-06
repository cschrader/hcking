# encoding: utf-8
class NewSuggestionMailer < ActionMailer::Base
  default from: "bodo@hcking.de"

  RECIPIENTS = ["bodo@wannawork.de", "lucas.dohmen@koeln.de"]

  def new_suggestion(record)
    @record = record
    mail to: RECIPIENTS, subject: "[hcking.de Vorschlag] Neuer Vorschlag eingereicht!"
  end

end
