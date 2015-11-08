root = (module?.exports ? this.Magister ?= {})

###*
# An appointment.
#
# @class Appointment
# @private
# @param _magisterObj {Magister} A Magister object this Appointment is child of.
# @constructor
###
class root.Appointment
	constructor: (@_magisterObj) ->
		###*
		# @property id
		# @final
		# @type Number
		###
		@id = root._getset "_id"
		###*
		# @property begin
		# @final
		# @type Date
		###
		@begin = root._getset "_begin"
		###*
		# @property end
		# @final
		# @type Date
		###
		@end = root._getset "_end"
		###*
		# @property beginBySchoolHour
		# @final
		# @type Number
		###
		@beginBySchoolHour = root._getset "_beginBySchoolHour"
		###*
		# @property endBySchoolHour
		# @final
		# @type Number
		###
		@endBySchoolHour = root._getset "_endBySchoolHour"
		###*
		# @property fullDay
		# @final
		# @type Boolean
		###
		@fullDay = root._getset "_fullDay"
		###*
		# @property description
		# @final
		# @type String
		###
		@description = root._getset "_description"
		###*
		# @property location
		# @final
		# @type String
		###
		@location = root._getset "_location"
		###*
		# @property status
		# @final
		# @type Number
		###
		@status = root._getset "_status"
		###*
		# @property type
		# @final
		# @type Number
		###
		@type = root._getset "_type"
		###*
		# type parsed as a string.
		# @property typeString
		# @final
		# @type String
		###
		@typeString = root._getset "_type", null, (x) ->
			switch x
				when 0 then 'none'
				when 1 then 'personal'
				when 2 then 'general'
				when 3 then 'schoolwide'
				when 4 then 'internship'
				when 5 then 'intake'
				when 6 then 'scheduleFree'
				when 7 then 'kwt'
				when 8 then 'standby'
				when 9 then 'block'
				when 10 then 'miscellaneous'
				when 11 then 'localBlock'
				when 12 then 'classBlock'
				when 13 then 'lesson'
				when 14 then 'studiehuis'
				when 15 then 'scheduleFreeStudy'
				when 16 then 'planning'
				# what's up with this big hole here, schoolmaster?
				when 101 then 'actions'
				when 102 then 'presences'
				when 103 then 'examSchedule'

				else 'unknown'
		###*
		# @property displayType
		# @final
		# @type Number
		###
		@displayType = root._getset "_displayType"
		###*
		# displayType parsed as a string.
		# @property displayTypeString
		# @final
		# @type String
		###
		@displayTypeString = root._getset "_displayType", null, (x) ->
			switch x
				when 1 then 'available'
				when 2 then 'provisionallyScheduled'
				when 3 then 'scheduled'
				when 4 then 'absent'

				else 'unknown'
		###*
		# @property content
		# @final
		# @type String
		###
		@content = root._getset "_content", null, root._helpers.cleanHtmlContent
		###*
		# @property infoType
		# @final
		# @type Number
		###
		@infoType = root._getset "_infoType"
		###*
		# infoType parsed as a string.
		# @property infoTypeString
		# @final
		# @type String
		###
		@infoTypeString = root._getset "_infoType", null, (x) ->
			switch x
				when 0 then 'none'
				when 1 then 'homework'
				when 2 then 'test'
				when 3 then 'exam'
				when 4 then 'quiz'
				when 5 then 'oral'
				when 6 then 'information'
				when 7 then 'annotation'

				else 'unknown'
		###*
		# @property notes
		# @final
		# @type String
		###
		@notes = root._getset "_notes"
		###*
		# @property isDone
		# @type Boolean
		###
		@isDone = root._getset "_isDone", (d) =>
			return if @_isDone is d

			@_isDone = d
			@_magisterObj.http.put @url(), @_toMagisterStyle(), {}, (->)
		###*
		# @property classes
		# @final
		# @type String[]
		###
		@classes = root._getset "_classes"
		###*
		# @property teachers
		# @final
		# @type Person[]
		###
		@teachers = root._getset "_teachers"
		###*
		# @property classRooms
		# @final
		# @type String[]
		###
		@classRooms = root._getset "_classRooms"
		###*
		# @property groups
		# @final
		# @type String[]
		###
		@groups = root._getset "_groups"
		###*
		# @property appointmentId
		# @final
		# @type Number
		###
		@appointmentId = root._getset "_appointmentId"
		###*
		# @property attachments
		# @final
		# @type File[]
		###
		@attachments = root._getset "_attachments"
		###*
		# @property url
		# @final
		# @type String
		###
		@url = root._getset "_url"
		###*
		# @property scrapped
		# @final
		# @type Boolean
		###
		@scrapped = root._getset "_scrapped"
		###*
		# @property changed
		# @final
		# @type Boolean
		###
		@changed = root._getset "_changed"
		###*
		# @property absenceInfo
		# @final
		# @type Object
		###
		@absenceInfo = root._getset "_absenceInfo"

	###*
	# WARNING. Removes the current Appointment if created by the user.
	# @method remove
	# @param [callback] {Function} An optional callback.
	# 	@param [callback.error] {Object} An error, if it exists.
	###
	remove: (cb) ->
		# quit if this appointment isn't made by the user.
		return unless @_type in [ 1, 16 ]
		@_magisterObj.http.delete @_url, {}, _.ary cb, 1

	_toMagisterStyle: ->
		obj = {}

		obj.Id = @_id
		obj.Start = root._helpers.toUtcString @_begin
		obj.Einde = root._helpers.toUtcString @_end
		obj.LesuurVan = @_beginBySchoolHour
		obj.LesuurTotMet = @_endBySchoolHour
		obj.DuurtHeleDag = @_fullDay
		obj.Omschrijving = @_description
		obj.Lokatie = @_location
		obj.Status = @_status
		obj.Type = @_type
		obj.WeergaveType = @_displayType
		obj.Inhoud = @_content
		obj.InfoType = @_infoType
		obj.Aantekening = @_notes
		obj.Afgerond = @_isDone
		obj.Lokalen = ( { Naam: c } for c in @_classRooms )
		obj.Docenten = ( p._toMagisterStyle() for p in @_teachers )
		obj.Vakken = ( { Naam: c } for c in @_classes )
		obj.Groepen = @_groups
		obj.OpdrachtId = @_appointmentId
		obj.Bijlagen = @_attachments ? []

		return obj

	@_convertRaw: (magisterObj, raw) ->
		obj = new root.Appointment magisterObj

		obj._id = raw.Id
		obj._begin = new Date Date.parse raw.Start
		obj._end = new Date Date.parse raw.Einde
		obj._beginBySchoolHour = raw.LesuurVan
		obj._endBySchoolHour = raw.LesuurTotMet
		obj._fullDay = raw.DuurtHeleDag
		obj._description = raw.Omschrijving ? ""
		obj._location = raw.Lokatie ? ""
		obj._status = raw.Status
		obj._type = raw.Type
		obj._displayType = raw.WeergaveType
		obj._content = raw.Inhoud
		obj._infoType = raw.InfoType
		obj._notes = raw.Aantekening
		obj._isDone = raw.Afgerond
		obj._classes = if raw.Vakken? then (c.Naam for c in raw.Vakken) else []
		obj._teachers = if raw.Docenten? then (root.Person._convertRaw(magisterObj, p) for p in raw.Docenten) else []
		obj._classRooms = if raw.Lokalen? then (c.Naam for c in raw.Lokalen) else []
		obj._groups = raw.Groepen # ?
		obj._appointmentId = raw.OpdrachtId
		obj._attachments = raw.Bijlagen
		obj._url = "#{magisterObj._personUrl}/afspraken/#{obj._id}"
		obj._scrapped = raw.Status in [ 4, 5 ]
		obj._changed = raw.Status in [ 3, 9, 10 ]

		obj

	@_convertStored: (magisterObj, raw) ->
		obj = _.extend raw, new root.Appointment magisterObj
		obj._magisterObj = magisterObj
		obj._begin = new Date Date.parse raw._begin
		obj._end = new Date Date.parse raw._end
		return obj
