package com.example.gostudy;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import java.util.ArrayList;

public class TipsFragment extends Fragment {
    boolean courseSelected = false;
    int tipIndex = 1;
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState){
        final View root = inflater.inflate(R.layout.fragment_tips, container, false);
        Button postBtn=(Button) root.findViewById(R.id.submitTipBtn);
        EditText usrTip = (EditText) root.findViewById(R.id.AddTipEditText);

        //create spinner courses
        Spinner courses_Spinner = root.findViewById(R.id.spr_courses);
        ArrayList<String> courses = new ArrayList<>();
        courses.add(0, "choose course");
        courses.add("General");
        courses.add("Algorithms");
        courses.add("Linear algebra 1");
        courses.add("Linear algebra 2");
        courses.add("Introduction into computer science");
        courses.add("Hedva 1");
        courses.add("Hedva 2");
        courses.add("Software project");
        ArrayAdapter<String> arrayAdapter_courses = new ArrayAdapter<String>(this.getActivity(), android.R.layout.simple_spinner_item, courses);
        arrayAdapter_courses.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        courses_Spinner.setAdapter(arrayAdapter_courses);
        courses_Spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String text = (String) parent.getItemAtPosition(position);
                if (parent.getId() == R.id.spr_courses){
                    if (text == "choose course"){
                        courseSelected = false;
                    }else{
                        courseSelected = true;
                    }

                }

            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });


        // TextView for user's tips display.
        TextView tip1=(TextView) root.findViewById(R.id.Tip1);
        TextView tip2=(TextView) root.findViewById(R.id.Tip2);
        TextView tip3=(TextView) root.findViewById(R.id.Tip3);
        TextView tip4=(TextView) root.findViewById(R.id.Tip4);
        TextView tip5=(TextView) root.findViewById(R.id.Tip5);
        TextView tip6=(TextView) root.findViewById(R.id.Tip6);
        TextView tip7=(TextView) root.findViewById(R.id.Tip7);
        TextView tip8=(TextView) root.findViewById(R.id.Tip8);
        TextView tip9=(TextView) root.findViewById(R.id.Tip9);
        TextView tip10=(TextView) root.findViewById(R.id.Tip10);

        ArrayList<TextView> tips = new ArrayList<>();
        tips.add(tip1);tips.add(tip2);tips.add(tip3);tips.add(tip4);tips.add(tip5);
        tips.add(tip6);tips.add(tip7);tips.add(tip8);tips.add(tip9);tips.add(tip10);
        
        postBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                addATip(tips, usrTip.getText().toString());
                usrTip.setText("");
            }
        });

        return root;
    }
    /** Add the user's tip*/
    private void addATip(ArrayList tips, String usrTip) {
            TextView tip=(TextView) tips.get(tipIndex++);
            tip.setText("- "+usrTip);
            return;
    }

}
