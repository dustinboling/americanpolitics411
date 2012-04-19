class IssueMainIssue < ActiveRecord::Base

  belongs_to :issue
  belongs_to :main_issue

end
