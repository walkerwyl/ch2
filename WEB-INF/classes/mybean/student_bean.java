package mybean;

import java.util.HashSet;
import java.util.Set;

public class student_bean {
    String Name,Stu_ID;
    int Gender;
    public Set infos = new HashSet();

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getStu_ID() {
        return Stu_ID;
    }

    public void setStu_ID(String Stu_ID) {
        this.Stu_ID = Stu_ID;
    }

    public int getGender() {
        return Gender;
    }

    public void setGender(int Gender) {
        this.Gender = Gender;
    }
    
}
