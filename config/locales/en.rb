{
  en: {
    search: "Search",
    login: "Login",
    profile: "Profile",
    edit_profile: "Edit Profile",
    edit: "Edit",
    new: "New",
    delete: "Delete",
    update: "Update",
    logout: "Log out",
    register: "Register",
    categories: "Categories",
    last_added_phrases: "Latest added phrases",
    reset_password: "Send me reset password instructions",
    forgot_password: "Forgot your password?",
    config: {
      cms: {
        default_title: 'Frases 480'
      }
    },

    date: {
      abbr_day_names: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      abbr_month_names: [nil, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      day_names: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
      formats: {
        default: '%Y-%m-%d',
        long: ->(date, _) { "%B #{date.day.ordinalize}, %Y" },
        short: '%b %d',
        complete: '%a, %d %B %Y',
        month_day_ord: ->(date, _) { "%b #{date.day.ordinalize}" },
        full_month_day_ord: ->(date, _) { "%B #{date.day.ordinalize}" },
      },
      month_names: [nil, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
      order: [:year, :month, :day]
    },

    time: {
      am: 'am',
      formats: {
        default: '%a, %d %b %Y %I:%M:%S %z',
        long: '%B %d, %Y %I:%M %p',
        short: '%d %b %I:%M %p',
        complete: '%a, %d %B %Y %I:%M %p',
        complete_with_tz: '%a, %d %B %Y %I:%M %p %Z',
        datetimepicker: '%Y-%m-%d %I:%M %p',
        compact: '%B, %d %Y',
        month_day_ord: ->(date, _) { "%b #{date.day.ordinalize}" },
        month_day_year_ord: ->(date, _) { "%b #{date.day.ordinalize}, %Y" },
        full_month_day_ord: ->(date, _) { "%B #{date.day.ordinalize}" },
        time_only: '%I:%M %p',
        time_long: '%I:%M:%S'
      },
      pm: 'pm'
    },

    datetime: {
      distance_in_words: {
        about_x_hours: {
          one: 'about 1 hour',
          other: 'about %{count} hours'
        },
        about_x_months: {
          one: 'about 1 month',
          other: 'about %{count} months'
        },
        about_x_years: {
          one: 'about 1 year',
          other: 'about %{count} years'
        },
        almost_x_years: {
          one: 'almost 1 year',
          other: 'almost %{count} years'
        },
        half_a_minute: 'half a minute',
        less_than_x_minutes: {
          one: 'less than a minute',
          other: 'less than %{count} minutes'
        },
        less_than_x_seconds: {
          one: 'less than 1 second',
          other: 'less than %{count} seconds'
        },
        over_x_years: {
          one: 'over 1 year',
          other: 'over %{count} years'
        },
        x_days: {
          one: '1 day',
          other: '%{count} days'
        },
        x_minutes: {
          one: '1 minute',
          other: '%{count} minutes'
        },
        x_months: {
          one: '1 month',
          other: '%{count} months'
        },
        x_seconds: {
          one: '1 second',
          other: '%{count} seconds'
        }
      },
      prompts: {
        day: 'Day',
        hour: 'Hour',
        minute: 'Minute',
        month: 'Month',
        second: 'Seconds',
        year: 'Year'
      }
    },

    errors: {
      format: '%{attribute} %{message}',
      messages: {
        accepted: 'must be accepted',
        blank: 'cannot be blank',
        present: 'must be blank',
        confirmation: "doesn't match %{attribute}",
        empty: 'cannot be empty',
        equal_to: 'must be equal to %{count}',
        even: 'must be even',
        exclusion: 'is reserved',
        greater_than: 'must be greater than %{count}',
        greater_than_or_equal_to: 'must be greater than or equal to %{count}',
        inclusion: 'is not included in the list',
        invalid: 'is invalid',
        less_than: 'must be less than %{count}',
        less_than_or_equal_to: 'must be less than or equal to %{count}',
        not_a_number: 'is not a number',
        not_an_integer: 'must be an integer',
        odd: 'must be odd',
        record_invalid: 'Validation failed: %{errors}',
        restrict_dependent_destroy: {
          one: 'Cannot delete record because a dependent %{record} exists',
          many: 'Cannot delete record because dependent %{record} exist'
        },
        taken: 'has already been taken',
        too_long: {
          one: 'is too long (maximum is 1 character)',
          other: 'is too long (maximum is %{count} characters)'
        },
        too_short: {
          one: 'is too short (minimum is 1 character)',
          other: 'is too short (minimum is %{count} characters)'
        },
        wrong_length: {
          one: 'is the wrong length (should be 1 character)',
          other: 'is the wrong length (should be %{count} characters)'
        },
        other_than: 'must be other than %{count}',
        must_choose: 'you must choose at least one'
      },
      template: {
        body: 'There were problems with the following fields:',
        header: {
          one: '1 error prohibited this %{model} from being saved',
          other: '%{count} errors prohibited this %{model} from being saved'
        }
      }
    },

    helpers: {
      select: {
        prompt: 'Please select'
      },
      submit: {
        create: 'Create %{model}',
        submit: 'Save %{model}',
        update: 'Update %{model}'
      }
    },

    number: {
      currency: {
        format: {
          delimiter: ',',
          format: '%u%n',
          precision: 2,
          separator: '.',
          significant: false,
          strip_insignificant_zeros: false,
          unit: '$'
        }
      },
      format: {
        delimiter: ',',
        precision: 2,
        separator: '.',
        significant: false,
        strip_insignificant_zeros: false
      },
      human: {
        decimal_units: {
          format: '%n %u',
          units: {
            billion: 'Billion',
            million: 'Million',
            quadrillion: 'Quadrillion',
            thousand: 'Thousand',
            trillion: 'Trillion',
            unit: ''
          }
        },
        format: {
          delimiter: ',',
          precision: 2,
          significant: true,
          strip_insignificant_zeros: true
        },
        storage_units: {
          format: '%n %u',
          units: {
            byte: {
              one: 'Byte',
              other: 'Bytes'
            },
            gb: 'GB',
            kb: 'KB',
            mb: 'MB',
            tb: 'TB'
          }
        }
      },
      percentage: {
        format: {
          delimiter: '',
          format: '%n%'
        }
      },
      precision: {
        format: {
          precision: 2,
          delimiter: ','
        }
      }
    },

    support: {
      array: {
        last_word_connector: ', and ',
        two_words_connector: ' and ',
        words_connector: ', '
      }
    },

    activemodel: {
      errors: {
        models: {
          user_auth: {
            attributes: {
              email: {
                no_user_found: 'We couldn\'t find any user with that email',
                no_access_profile_associated: 'The user doesn\'t have any associated Profile',
                inactive: 'The user is not active.'
              }
            }
          }
        }
      }
    },

    will_paginate: {
      previous_label: '&larr;',
      next_label: '&rarr;',
      page_gap: ' ... '
    },

    basic: {
      forms: {
        submit_create: 'Create',
        submit_update: 'Update',
        submit_delete: 'Delete',
        submit_upload: 'Upload',
        submit_search: 'Search',
        submit_register: 'Register',
        submit_find: 'Find',
        submit_import: 'Import',
        submit_add: 'Add',
        submit_save: 'Save Changes',
        submit: 'Submit',
        confirm: 'Are you sure?',
        loading: 'Loading ...',
        deleting: 'Deleting ...',
        updating: 'Updating ...',
        saving: 'Saving ...',
        searching: 'Searching ...',
        generating: 'Generating ...',
        creating: 'Creating',
        adding: 'Adding',
        uploading: 'Uploading',
        importing: 'Importing'
      },
      yes: 'yes',
      no: 'no',
      his: 'his',
      her: 'her',
      he: 'he',
      she: 'she'
    },

    models: {
      user: {
        status: {
          active: 'Active',
          blocked: 'Blocked',
          deleted: 'Deleted'
        }
      },
      access_profile: {
        status: {
          active: 'Active',
          deleted: 'Deleted'
        }
      }
    },

    alerts: {
      logout: 'Have a good day 👋',
      not_logged_in: 'You have to login first.'
    },

    breadcrumbs: {
      root: 'Dashboard',
      access_profiles: { main: 'Access Profiles', new: 'New', edit: 'Edit' },
      users: { main: 'Users', new: 'New', edit: 'Edit' }
    }
  }
}
