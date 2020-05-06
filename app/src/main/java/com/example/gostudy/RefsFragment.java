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

public class RefsFragment extends Fragment {
    boolean courseSelected = false;
    int tipIndex = 0;
    String text;
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState){
        final View root = inflater.inflate(R.layout.fragment_refs, container, false);
        Button postBtn=(Button) root.findViewById(R.id.submitTipBtn);
        EditText usrLink = (EditText) root.findViewById(R.id.AddTipEditText);
        EditText usrDescription = (EditText) root.findViewById(R.id.linkDescriptionEditText) ;

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
        TextView link1=(TextView) root.findViewById(R.id.Tip1);
        TextView Desc1=(TextView) root.findViewById(R.id.linkDescription1);
        Button likeBtn1=(Button) root.findViewById(R.id.likeBtn1);
        TextView link2=(TextView) root.findViewById(R.id.Tip2);
        TextView Desc2=(TextView) root.findViewById(R.id.linkDescription2);
        Button likeBtn2=(Button) root.findViewById(R.id.likeBtn2);
        TextView link3=(TextView) root.findViewById(R.id.Tip3);
        TextView Desc3=(TextView) root.findViewById(R.id.linkDescription3);
        Button likeBtn3=(Button) root.findViewById(R.id.likeBtn3);
        TextView link4=(TextView) root.findViewById(R.id.Tip4);
        TextView Desc4=(TextView) root.findViewById(R.id.linkDescription4);
        Button likeBtn4=(Button) root.findViewById(R.id.likeBtn4);
        TextView link5=(TextView) root.findViewById(R.id.Tip5);
        TextView Desc5=(TextView) root.findViewById(R.id.linkDescription5);
        Button likeBtn5=(Button) root.findViewById(R.id.likeBtn5);
        TextView link6=(TextView) root.findViewById(R.id.Tip6);
        TextView Desc6=(TextView) root.findViewById(R.id.linkDescription6);
        Button likeBtn6=(Button) root.findViewById(R.id.likeBtn6);
        TextView link7=(TextView) root.findViewById(R.id.Tip7);
        TextView Desc7=(TextView) root.findViewById(R.id.linkDescription7);
        Button likeBtn7=(Button) root.findViewById(R.id.likeBtn7);
        TextView link8=(TextView) root.findViewById(R.id.Tip8);
        TextView Desc8=(TextView) root.findViewById(R.id.linkDescription8);
        Button likeBtn8=(Button) root.findViewById(R.id.likeBtn8);
        TextView link9=(TextView) root.findViewById(R.id.Tip9);
        TextView Desc9=(TextView) root.findViewById(R.id.linkDescription9);
        Button likeBtn9=(Button) root.findViewById(R.id.likeBtn9);
        TextView link10=(TextView) root.findViewById(R.id.Tip10);
        TextView Desc10=(TextView) root.findViewById(R.id.linkDescription10);
        Button likeBtn10=(Button) root.findViewById(R.id.likeBtn10);

        /** tips and like buttons arrays*/
        ArrayList<TextView> links = new ArrayList<>();
        ArrayList<Button> likeBtns = new ArrayList<>();
        ArrayList<TextView> Descs=new ArrayList<>();

        links.add(link1);links.add(link2);links.add(link3);links.add(link4);links.add(link5);
        links.add(link6);links.add(link7);links.add(link8);links.add(link9);links.add(link10);

        likeBtns.add(likeBtn1);likeBtns.add(likeBtn2);likeBtns.add(likeBtn3);likeBtns.add(likeBtn4);likeBtns.add(likeBtn5);
        likeBtns.add(likeBtn6);likeBtns.add(likeBtn7);likeBtns.add(likeBtn8);likeBtns.add(likeBtn9);likeBtns.add(likeBtn10);

        Descs.add(Desc1);Descs.add(Desc2);Descs.add(Desc3);Descs.add(Desc4);Descs.add(Desc5);
        Descs.add(Desc6);Descs.add(Desc7);Descs.add(Desc8);Descs.add(Desc9);Descs.add(Desc10);

        postBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!courseSelected){
                    return;
                }
                addATip(links, likeBtns ,Descs ,usrDescription.getText().toString(), usrLink.getText().toString(), text);
                usrLink.setText("");
                usrDescription.setText("");
            }
        });

        return root;
    }
    /** Add the user's tip*/
    private void addATip(ArrayList links,ArrayList likeBtns,ArrayList descriptions, String usrDesc, String usrLink, String course) {
        if(tipIndex>9){return;}

        TextView link=(TextView) links.get(tipIndex);
        TextView Descr = (TextView) descriptions.get(tipIndex);
        Button likeBtn = (Button) likeBtns.get(tipIndex++);
        Descr.setText("# "+course+" # - "+usrDesc);
        link.setText(usrLink);
        likeBtn.setVisibility(View.VISIBLE);
        //likeBtn.setClickable(true);//
        return;
    }
}
