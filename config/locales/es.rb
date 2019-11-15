{
  es: {
    search: "Buscar",
    login: "Loguear",
    profile: "Perfil",
    edit_profile: "Editar Perfil",
    edit: "Editar",
    new: "Nuevo",
    delete: "Borrar",
    update: "Actualizar",
    logout: "Cerrar sesión",
    register: "Registrarse",
    categories: "Categorias",
    last_added_phrases: "Últimas frases añadidas",
    reset_password: "Enviarme las instrucciones para recuperar contraseña",
    forgot_password: "¿Olvidaste tu contraseña?",
    config: {
      cms: {
        default_title: 'Frases 480'
      }
    },

    date: {
      abbr_day_names: %w[Dom Lun Mar Mie Jue Vie Sab],
      abbr_month_names: [nil, 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
      day_names: %w[Domingo Lunes Martes Miércoles Jueves Viernes Sábado],
      formats: {
        default: '%Y-%m-%d',
        long: '%B %d, %Y',
        short: '%b %d',
        short_chart: '%d %b',
        complete: '%a, %d %B %Y',
        complete_abbr: '%a, %d/%b/%Y',
        shorty: '%d/%b/%y',
        datepicker: '%d-%m-%Y'
      },
      month_names: [nil, 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
      order: [:day, :month, :year]
    },

    datetime: {
      distance_in_words: {
        about_x_hours: {
          one: 'Hace 1 hora',
          other: 'Hace %{count} horas'
        },
        about_x_months: {
          one: 'Hace 1 mes',
          other: 'Hace %{count} meses'
        },
        about_x_years: {
          one: 'Hace 1 año',
          other: 'about %{count} años'
        },
        almost_x_years: {
          one: 'Casi 1 año',
          other: 'Casi %{count} años'
        },
        half_a_minutes: 'half a minuto',
        less_than_x_minutes: {
          one: 'Menos de un minuto',
          other: 'Menos de %{count} minutos'
        },
        less_than_x_seconds: {
          one: 'Menos de 1 segundo',
          other: 'Menos de %{count} segundos'
        },
        over_x_years: {
          one: 'Más de 1 año',
          other: 'Más de %{count} años'
        },
        x_days: {
          one: '1 día',
          other: '%{count} días'
        },
        x_minutes: {
          one: '1 minuto',
          other: '%{count} minutos'
        },
        x_months: {
          one: '1 mes',
          other: '%{count} meses'
        },
        x_seconds: {
          one: '1 segundo',
          other: '%{count} segundos'
        }
      },
      prompts: {
        día: 'Día',
        hora: 'Hora',
        minuto: 'Minuto',
        mes: 'Mes',
        segundo: 'Segundo',
        año: 'Año'
      }
    },

    errors: {
      format: '%{attribute} %{message}',
      messages: {
        accepted: 'Debe ser aceptable',
        blank: 'No puede estar en blanco',
        present: 'Debe estar en blanco',
        confirmation: 'No es igual a %{attribute}',
        empty: 'No puede estar vacío',
        equal_to: 'Debe ser igual a %{count}',
        even: 'Debe ser par',
        exclusion: 'Está reservado',
        greater_than: 'Debe ser mayor a %{count}',
        greater_than_or_equal_to: 'Debe ser mayor o igual a %{count}',
        inclusion: 'No esta incluído en la lista',
        invalid: 'Es inválido',
        less_than: 'Debe ser menor a %{count}',
        less_than_or_equal_to: 'Debe ser menor o igual a %{count}',
        not_a_number: 'No es un número',
        not_an_integer: 'Debe ser un número entero',
        odd: 'Debe ser impar',
        record_invalid: 'La validación ha fallado: %{errors}',
        restrict_dependent_destroy: {
          one: 'No puede eliminar el registro por que posee otros registros dependiente: %{record}',
          many: 'No puede eliminar el registro por que posee otros registros dependiente %{record}'
        },
        taken: 'Ya ha sido tomado',
        too_long: {
          one: 'Es muy largo (máximo 1 carácter)',
          other: 'Es muy largo (máximo %{count} caracteres)'
        },
        too_short: {
          one: 'Es muy corto (mínimo 1 carácter)',
          other: 'Es muy corto (mínimo %{count} caracteres)'
        },
        wrong_length: {
          one: 'Es la longitud incorrecta (debe ser de 1 carácter)',
          other: 'Es la longitud incorrecta (debe ser %{count} caracteres)'
        },
        other_than: 'Debe ser otro que %{count}',
        must_choose: 'Debe seleccionar al menos uno'
      },
      template: {
        body: 'Hubieron problemas con los siguientes campos:',
        header: {
          one: '1 error prohibio que el registro (%{model}) pueda ser guardado',
          other: '%{count} errores prohibieron que el registro (%{model}) pueda ser guardado'
        }
      }
    },

    helpers: {
      select: {
        prompt: 'Seleccionar'
      },
      submit: {
        create: 'Crear %{model}',
        submit: 'Guardar %{model}',
        update: 'Acualizar %{model}'
      }
    },

    number: {
      currency: {
        format: {
          delimiter: '.',
          format: '%u%n',
          precision: 0,
          separator: ', ',
          significant: false,
          strip_insignificant_zeros: false,
          unit: 'Gs. '
        }
      },
      format: {
        delimiter: '.',
        precision: 3,
        separator: ', ',
        significant: false,
        strip_insignificant_zeros: false
      },
      human: {
        decimal_units: {
          format: '%n %u',
          units: {
            billion: 'Billones',
            million: 'Millón',
            quadrillion: 'Cuatrillón',
            thousand: 'Mil',
            trillion: 'Trillón',
            unit: ''
          }
        },
        format: {
          delimiter: '',
          precision: 3,
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
          delimiter: ''
        }
      }
    },

    support: {
      array: {
        last_word_connector: ', y ',
        two_words_connector: ' y ',
        words_connector: ', '
      }
    },

    time: {
      am: 'am',
      formats: {
        default: '%a, %d %b %Y %H:%M:%S %z',
        long: '%B %d, %Y %H:%M',
        short: '%d %b %H:%M',
        complete: '%a, %d %B %Y %H:%M',
        datetimepicker: '%Y-%m-%d %H:%M',
        compact: '%B, %d %Y'
      },
      pm: 'pm'
    },

    activemodel: {
      errors: {
        models: {
          cms_user_auth: {
            attributes: {
              email: {
                no_user_found: 'No pudimos encontrar un usuario con ese email',
                no_access_profile_associated: 'El usuario no tiene un perfil de acceso asaciado',
                inactive: 'El usuario no esta activo.'
              }
            }
          }
        }
      }
    },

    basic: {
      forms: {
        submit_create: 'Crear',
        submit_update: 'Actualizar',
        submit_delete: 'Eliminar',
        submit_destroy: 'Destruir',
        submit_upload: 'Subir',
        submit_search: 'Buscar',
        submit_save: 'Guardar',
        submit_add: 'Agregar',
        submit_reset: 'Resetear',
        submit_create_and_add_f: 'Crear y agregar otra',
        confirm: 'Está seguro?',
        loading: 'Cargando ...',
        deleting: 'Eliminando ...',
        updating: 'Actualizando ...',
        saving: 'Guardando ...',
        searching: 'Buscando ...',
        creating: 'Creando ...',
        adding: 'Agregando ...',
        uploading: 'Subiendo ...',
        sending: 'Enviando ...'
      },
      yes: 'si',
      no: 'no'
    },

    alerts: {
      cms: {
        logout: 'Hasta la próxima! 👋',
        access_denied: 'Acceso Denegado 🛑',
        not_logged_in: 'Tienes que iniciar sesión primero'
      }
    },

    breadcrumbs: {
      root: 'Escritorio',
      access_profiles: { main: 'Perfiles de Acceso', new: 'Nuevo', edit: 'Editar' },
      users: { main: 'Usuarios', new: 'Nuevo', edit: 'Editar' },
      categories: { main: 'Categorías', new: 'Nuevo', edit: 'Editar' },
      phrases: { main: 'Frases', new: 'Nuevo', edit: 'Editar' }
    },

    models: {
      phrase: {
        status: {
          active: 'Activo',
          pending: 'Pendiente',
          rejected: 'Rechazado',
          deleted: 'Eliminado'
        }
      },
      category: {
        status: {
          active: 'Activo',
          inactive: 'Inactivo',
          blocked: 'Bloqueado',
          deleted: 'Eliminado'
        }
      },
      access_profile: {
        status: {
          active: 'Activo',
          blocked: 'Bloqueado',
          deleted: 'Eliminado'
        }
      },
      user: {
        status: {
          active: 'Activo',
          blocked: 'Bloqueado',
          deleted: 'Eliminado'
        }
      }
    }
  }
}
