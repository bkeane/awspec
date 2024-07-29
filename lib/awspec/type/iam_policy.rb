# frozen_string_literal: true

require 'awspec/error'

module Awspec::Type
  class IamPolicy < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_iam_policy(@display_name)
    end

    def id
      @id ||= resource_via_client.policy_id if resource_via_client
    end

    def attachable?
      check_existence
      resource_via_client.is_attachable
    end

    def attached_to_user?(user_id = nil)
      check_existence
      users = select_attached_users(id)
      if user_id
        user = find_iam_user(user_id)
        return false unless user

        users.any? do |u|
          u.user_name == user.user_name
        end
      else
        !users.empty?
      end
    end

    def attached_to_group?(group_id = nil)
      check_existence
      groups = select_attached_groups(@id)
      if group_id
        group = find_iam_group(group_id)
        return false unless group

        groups.any? do |g|
          g.group_name == group.group_name
        end
      else
        !groups.empty?
      end
    end

    def attached_to_role?(role_id = nil)
      check_existence
      roles = select_attached_roles(@id)
      if role_id
        role = find_iam_role(role_id)
        return false unless role

        roles.any? do |r|
          r.role_name == role.role_name
        end
      else
        !roles.empty?
      end
    end

    def has_tag?(tag_key, tag_value)
      resource_tags = iam_client.list_policy_tags(policy_arn: resource_via_client.arn).tags
      resource_tags.any? do |tag|
        tag.key == tag_key && tag.value == tag_value
      end
    end

    def has_policy_document?(document)
      res = iam_client.get_policy_version({
                                            policy_arn: resource_via_client.arn,
                                            version_id: resource_via_client.default_version_id
                                          })

      JSON.parse(URI.decode_www_form_component(res.policy_version.document)) == JSON.parse(document)
    end
  end
end
