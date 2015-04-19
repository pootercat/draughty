require 'autodraft'

namespace :draft do
  task simulate: :environment do
    auto_draft = AutoDraft.new
    auto_draft.draft
  end

end
