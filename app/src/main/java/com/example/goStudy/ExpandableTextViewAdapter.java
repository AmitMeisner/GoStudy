package com.example.goStudy;

import android.content.Context;
import android.graphics.Typeface;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseExpandableListAdapter;
import android.widget.TextView;

public class ExpandableTextViewAdapter extends BaseExpandableListAdapter {

    Context context;


    String[] goalsExpandable= {
            "Weekly Goals",
            "Semester Goals"
    };

    String[] []answers={{"- 4 hours Homework\n"+
            "- 8 hours recitations\n"+
            "- 4 hours preperations for class\n"+
            "- 15 hours Google - Workshop\n"},
            {"- 40 hours Homework\n"+
                    "- 80 hours recitations\n"+
                    "- 40 hours preperations for class\n"+
                    "- 50 Problems From Tests\n"+
                    "- 100 hours Google - Workshop\n"}
    };

    public ExpandableTextViewAdapter(Context context) {
        this.context = context;
    }

    @Override
    public int getGroupCount() {
        return goalsExpandable.length;
    }

    @Override
    public int getChildrenCount(int i) {
        return answers[i].length;
    }

    @Override
    public Object getGroup(int i) {
        return goalsExpandable[i];
    }

    @Override
    public Object getChild(int i, int i1) {
        return answers[i][i1];
    }

    @Override
    public long getGroupId(int i) {
        return i;
    }

    @Override
    public long getChildId(int i, int i1) {
        return i1;
    }

    @Override
    public boolean hasStableIds() {
        return false;
    }

    //getting headlines for collapse window
    @Override
    public View getGroupView(int i, boolean b, View view, ViewGroup viewGroup) {

        String goalsPosition = (String)getGroup(i);
        if (view==null){
            LayoutInflater inflater = (LayoutInflater)this.context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            view = inflater.inflate(R.layout.weekly_goals_expand,null);
        }
        TextView goalsExpandNew = view.findViewById(R.id.weeklyGoalsView);
        goalsExpandNew.setTypeface(null, Typeface.BOLD);
        goalsExpandNew.setText(goalsPosition);
        return view;
    }

    //open answers for matched headlines
    @Override
    public View getChildView(int i, int i1, boolean b, View view, ViewGroup viewGroup) {
        final String answer = (String)getChild(i,i1);
        if (view==null){
            LayoutInflater inflater =(LayoutInflater)this.context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            view = inflater.inflate(R.layout.weekly_goals_expand_answer,null);
        }
        TextView answerExpandNew = view.findViewById(R.id.weeklyGoalsExpandAnswer);
        answerExpandNew.setText(answer);
        return view;
    }

    @Override
    public boolean isChildSelectable(int i, int i1) {
        return false;
    }
}
