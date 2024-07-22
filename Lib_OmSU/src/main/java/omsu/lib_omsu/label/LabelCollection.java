package omsu.lib_omsu.label;

import omsu.lib_omsu.users.User;

import java.util.*;
import java.util.Map;
import java.util.Collection;
import java.util.LinkedHashMap;

public class LabelCollection
{
    Map<Long, Label> labelMap = new LinkedHashMap<>();

    public LabelCollection()
    {
       /* Label label1 = new Label("ASP");
        Label label2 = new Label("Лань");
        Label label3 = new Label("Ficbook");

        put(label1);
        put(label2);
        put(label3);*/
    }

    public Long put(Label label)
    {
        labelMap.put(label.getId(), label);
        return label.getId();
    }
    public void remove(Label label)
    {
        labelMap.remove(label.getId());
    }

    @Override
    public String toString()
    {
        return labelMap.toString();
    }

    public Iterator<Label> getLabelMapIterator()
    {
        return labelMap.values().iterator();
    }

    public Set<Long> getLabelMapKeys()
    {
        return labelMap.keySet();
    }

    public Collection<Label> findAll()
    {
        return labelMap.values();
    }

    public Set<Label> findAll(Label label, String pattern){
        Set<Label> labelSet = new HashSet<>();
        if (label != null)
        {
            for (Label l : labelMap.values())
            {
                if(l.getName() != null && l.getName().equals(pattern))
                {
                    labelSet.add(l);
                }
            }
        }
        return labelSet;
    }

    public Label get(Long id) {
        return labelMap.get(id);
    }

    public HashSet<Label> getLabelValues() {
        System.out.println("Label="+labelMap.values());
        return new HashSet<Label>(labelMap.values());
    }

    public void setLabelCollection(Map<Long, Label> labelMap) {
        this.labelMap = labelMap;
    }
}