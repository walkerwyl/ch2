package mybean;

import java.util.HashSet;
import java.util.Set;

public class teacher_bean {
    String Name,Tea_ID;
    int Gender;
    
    public Set sources = new HashSet();
    public Set classes = new HashSet();

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getTea_ID() {
        return Tea_ID;
    }

    public void setTea_ID(String Tea_ID) {
        this.Tea_ID = Tea_ID;
    }

    public int getGender() {
        return Gender;
    }

    public void setGender(int Gender) {
        this.Gender = Gender;
    }

    public Set getSources() {
        return sources;
    }

    public void setSources(Set sources) {
        this.sources = sources;
    }

    public Set getClasses() {
        return classes;
    }

    public void setClasses(Set classes) {
        this.classes = classes;
    }
}
