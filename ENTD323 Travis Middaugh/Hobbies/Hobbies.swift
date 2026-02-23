class Hobbies{
    var hobby: String
    var status: String // status should include the phase of the project that we are in (idea/active/done)
    var notes: String
    var timespent: String
    
    init (hobby: String, status: String, notes: String, timespent: String){
        self.hobby = hobby
        self.status = status
        self.notes = notes
        self.timespent = timespent
    }
}
