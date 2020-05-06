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
    int tipIndex = 0;
    String text;

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
                text = (String) parent.getItemAtPosition(position);
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
        Button likeBtn1=(Button) root.findViewById(R.id.likeBtn1);
        TextView tip2=(TextView) root.findViewById(R.id.Tip2);
        Button likeBtn2=(Button) root.findViewById(R.id.likeBtn2);
        TextView tip3=(TextView) root.findViewById(R.id.Tip3);
        Button likeBtn3=(Button) root.findViewById(R.id.likeBtn3);
        TextView tip4=(TextView) root.findViewById(R.id.Tip4);
        Button likeBtn4=(Button) root.findViewById(R.id.likeBtn4);
        TextView tip5=(TextView) root.findViewById(R.id.Tip5);
        Button likeBtn5=(Button) root.findViewById(R.id.likeBtn5);
        TextView tip6=(TextView) root.findViewById(R.id.Tip6);
        Button likeBtn6=(Button) root.findViewById(R.id.likeBtn6);
        TextView tip7=(TextView) root.findViewById(R.id.Tip7);
        Button likeBtn7=(Button) root.findViewById(R.id.likeBtn7);
        TextView tip8=(TextView) root.findViewById(R.id.Tip8);
        Button likeBtn8=(Button) root.findViewById(R.id.likeBtn8);
        TextView tip9=(TextView) root.findViewById(R.id.Tip9);
        Button likeBtn9=(Button) root.findViewById(R.id.likeBtn9);
        TextView tip10=(TextView) root.findViewById(R.id.Tip10);
        Button likeBtn10=(Button) root.findViewById(R.id.likeBtn10);

        /** tips and like buttons arrays*/
        ArrayList<TextView> tips = new ArrayList<>();
        ArrayList<Button> likeBtns = new ArrayList<>();

        tips.add(tip1);tips.add(tip2);tips.add(tip3);tips.add(tip4);tips.add(tip5);
        tips.add(tip6);tips.add(tip7);tips.add(tip8);tips.add(tip9);tips.add(tip10);

        likeBtns.add(likeBtn1);likeBtns.add(likeBtn2);likeBtns.add(likeBtn3);likeBtns.add(likeBtn4);likeBtns.add(likeBtn5);
        likeBtns.add(likeBtn6);likeBtns.add(likeBtn7);likeBtns.add(likeBtn8);likeBtns.add(likeBtn9);likeBtns.add(likeBtn10);


        postBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!courseSelected){
                    return;
                }
                addATip(tips, likeBtns ,usrTip.getText().toString(), text);
                usrTip.setText("");
            }
        });

        return root;
    }
    /** Add the user's tip*/
    private void addATip(ArrayList tips,ArrayList likeBtns, String usrTip, String course) {
            if(tipIndex>9){return;}
            TextView tip=(TextView) tips.get(tipIndex);
            Button likeBtn = (Button) likeBtns.get(tipIndex++);
            tip.setText("# "+course+" # - "+usrTip);
            likeBtn.setVisibility(View.VISIBLE);
            //likeBtn.setClickable(true);//
            return;
    }

}
