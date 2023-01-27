require "include/protoplug"

local blockEvents = {}
local noteState = {}
local baseState = {}

local nChordNotes = 3
local baseNoteStart = 36
local chordNotesPassthrough = false
local root5 = false


local notes = {"C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B"}

local chordsTable={}
chordsTable["0-1-3-6-8"] = {root = 4, name = "11chord (1st inv)"}
chordsTable["0-1-3-7-10"] = {root = 2, name = "13chord (3rd inv)"}
chordsTable["0-1-4-8"] = {root = 1, name = "m(maj7) (3rd inv)"}
chordsTable["0-1-5-8"] = {root = 1, name = "maj7 (3rd inv)"}
chordsTable["0-1-8"] = {root = 1, name = "maj7sus (2nd inv)"}
chordsTable["0-2-3-5-9"] = {root = 3, name = "13chord (2nd inv)"}
chordsTable["0-2-4-6-9"] = {root = 1, name = "9chord (4th inv)"}
chordsTable["0-2-4-7-10"] = {root = 0, name = "9chord"}
chordsTable["0-2-4-7-9"] = {root = 0, name = "6/9"}
chordsTable["0-2-5"] = {root = 2, name = "6sus (1st inv)"}
chordsTable["0-2-5-7-10"] = {root = 4, name = "6/9 (1st inv)"}
chordsTable["0-2-5-7-11"] = {root = 3, name = "11chord (2nd inv)"}
chordsTable["0-2-5-7-9"] = {root = 2, name = "6/9 (3rd inv)"}
chordsTable["0-2-5-8"] = {root = 2, name = "minor6 (2nd inv)"}
chordsTable["0-2-5-8-10"] = {root = 4, name = "9chord (1st inv)"}
chordsTable["0-2-5-9"] = {root = 1, name = "minor7 (3rd inv)"}
chordsTable["0-2-6-7-9"] = {root = 1, name = "11chord (4th inv)"}
chordsTable["0-2-6-9"] = {root = 1, name = "7chord  (3rd inv)"}
chordsTable["0-2-6-9-11"] = {root = 1, name = "13chord (4th inv)"}
chordsTable["0-2-7"] = {root = 0, name = "sus2"}
chordsTable["0-2-8"] = {root = 1, name = "m7b5sus (2nd inv)"}
chordsTable["0-2-9"] = {root = 1, name = "7sus (2nd inv)"}
chordsTable["0-3-10"] = {root = 1, name = "6sus (2nd inv)"}
chordsTable["0-3-5"] = {root = 2, name = "7sus (1st inv)"}
chordsTable["0-3-5-6-8"] = {root = 4, name = "13chord (1st inv)"}
chordsTable["0-3-5-7-10"] = {root = 1, name = "6/9 (4th inv)"}
chordsTable["0-3-5-7-9"] = {root = 2, name = "9chord (3rd inv)"}
chordsTable["0-3-5-8"] = {root = 2, name = "minor7 (2st inv)"}
chordsTable["0-3-5-8-10"] = {root = 3, name = "6/9 (2nd inv)"}
chordsTable["0-3-5-9"] = {root = 2, name = "7chord  (2nd inv)"}
chordsTable["0-3-5-9-10"] = {root = 2, name = "11chord (3rd inv)"}
chordsTable["0-3-6"] = {root = 0, name = "dim"}
chordsTable["0-3-6-10"] = {root = 0, name = "m7b5"}
chordsTable["0-3-6-8"] = {root = 3, name = "7chord (1st inv)"}
chordsTable["0-3-6-8-10"] = {root = 3, name = "9chord (2nd inv)"}
chordsTable["0-3-6-9"] = {root = 0, name = "dim7"}
chordsTable["0-3-7"] = {root = 0, name = "minor"}
chordsTable["0-3-7-10"] = {root = 0, name = "minor7"}
chordsTable["0-3-7-11"] = {root = 0, name = "m(maj7)"}
chordsTable["0-3-7-8"] = {root = 3, name = "maj7 (1st inv)"}
chordsTable["0-3-7-9"] = {root = 0, name = "minor6"}
chordsTable["0-3-8"] = {root = 2, name = "major (1st inv) "}
chordsTable["0-3-9"] = {root = 2, name = "dim (1st inv)"}
chordsTable["0-4-5"] = {root = 2, name = "maj7sus (1st inv)"}
chordsTable["0-4-5-7-10"] = {root = 0, name = "11chord"}
chordsTable["0-4-5-8"] = {root = 2, name = "m(maj7) (2nd inv)"}
chordsTable["0-4-5-9"] = {root = 2, name = "maj7 (2nd inv)"}
chordsTable["0-4-6"] = {root = 2, name = "m7b5sus (1st inv)"}
chordsTable["0-4-6-9"] = {root = 3, name = "minor6 (1st inv)"}
chordsTable["0-4-7"] = {root = 0, name = "major"}
chordsTable["0-4-7-10"] = {root = 0, name = "7chord"}
chordsTable["0-4-7-11"] = {root = 0, name = "maj7"}
chordsTable["0-4-7-9"] = {root = 0, name = "6chord"}
chordsTable["0-4-7-9-10"] = {root = 0, name = "13chord"}
chordsTable["0-4-8"] = {root = 0, name = "aug"}
chordsTable["0-4-8-9"] = {root = 3, name = "m(maj7) (1st inv)"}
chordsTable["0-4-9"] = {root = 2, name = "minor (1st inv)"}
chordsTable["0-5"] = {root = 1, name = "5chord (1st inv)"}
chordsTable["0-5-10"] = {root = 2, name = "sus2 (1st inv)"}
chordsTable["0-5-7"] = {root = 0, name = "sus4"}
chordsTable["0-5-8"] = {root = 1, name = "minor (2nd inv)"}
chordsTable["0-5-9"] = {root = 1, name = "major (2nd inv)"}
chordsTable["0-6-10"] = {root = 0, name = "m7b5sus"}
chordsTable["0-6-9"] = {root = 1, name = "dim (2nd inv)"}
chordsTable["0-7"] = {root = 0, name = "5chord"}
chordsTable["0-7-10"] = {root = 0, name = "7sus"}
chordsTable["0-7-11"] = {root = 0, name = "maj7sus"}
chordsTable["0-7-9"] = {root = 0, name = "6sus"}

function split(input, delimiter)
    local words = {}
    for word in string.gmatch(input, "[^"..delimiter.."]+") do
        table.insert(words, word)
    end
    return words
end

function reduceNumber(limit, num)
    while num >= limit + 12 do
        num = num - 12
    end
    return num
end

function prettyPrint(obj, indent)
    indent = indent or ""
    if type(obj) == "table" then
        for key, value in pairs(obj) do
            print(indent .. key .. ": ")
            prettyPrint(value, indent .. "  ")
        end
    else
        print(indent .. tostring(obj))
    end
end

function plugin.processBlock(samples, smax, midiBuf)
	blockEvents = {}
	-- analyse midi buffer and prepare a chord for each note
	for ev in midiBuf:eachEvent() do
		if ev:isNoteOn() then
			noteOn(ev)
		elseif ev:isNoteOff() then
			noteOff(ev)
		end	
	end
	-- fill midi buffer with prepared notes
	midiBuf:clear()
	if #blockEvents>0 then
		for _,e in ipairs(blockEvents) do
			midiBuf:addEvent(e)
		end
	end
end

function allBaseNotesOff()
    for i, v in ipairs(baseState) do
        local newEv = midi.Event.noteOff(
            v:getChannel(), 
            v:getNote(), 
            v:getVel())
        table.insert(blockEvents, newEv)
    end
    baseState={}
end

function onOffBase(root)
    local chordNotes = {}
    local chord = ""
    for note, state in pairs(noteState) do
        if state == 1 then
            table.insert(chordNotes, note)
        end
    end
    if #chordNotes>0 then
        table.sort(chordNotes)
        local cNotes={}
        local base=chordNotes[1]
        for i=1,#chordNotes do
            cNotes[i]=chordNotes[i]-base
        end
        chord = {table.concat(cNotes, "-"),#cNotes,chordNotes}
        if (chord[2]==nChordNotes) then
            local chordName=chordsTable[chord[1]];
            if chordName then
                local rootChordNotes=split(chord[1], "-")
                local root=rootChordNotes[chordName.root+1]+base
                local rootNum=root%12
                local rootName=notes[rootNum+1]
                local baseNote=reduceNumber(baseNoteStart,root)
                chord = {table.concat(cNotes, "-"),#cNotes,chordNotes,rootName.." "..chordName.name,root,baseNote}
                print("number of notes="..chord[2].." notes="..chord[1].." chord="..chord[4].." root="..chord[5].." base="..chord[6])

            end
        end

    end
    if chord[6] then
        local baseEv = midi.Event.noteOn(
            root:getChannel(), 
            chord[6], 
            root:getVel())
        table.insert(blockEvents, baseEv)
        table.insert(baseState,baseEv)
        if root5 then
            local baseEv = midi.Event.noteOn(
                root:getChannel(), 
                chord[6]+7, 
                root:getVel())
            table.insert(blockEvents, baseEv)
            table.insert(baseState,baseEv)
        end
    else
        allBaseNotesOff()
    end
end

function noteOn(root)
    print(root:getNote())
    noteState[root:getNote()]=1
    if chordNotesPassthrough then
        local newEv = midi.Event.noteOn(
            root:getChannel(), 
            root:getNote(), 
            root:getVel())
        table.insert(blockEvents, newEv)
    end
    
    onOffBase(root)
    
end

function noteOff(root)
    noteState[root:getNote()]=0
    if chordNotesPassthrough then
        local newEv = midi.Event.noteOff(
            root:getChannel(), 
            root:getNote(), 
            root:getVel())
        table.insert(blockEvents, newEv)
    end
    
    onOffBase(root)
    
end



-- # EXPOSED PARAMETERS

plugin.manageParams {
    { name = "N of Chord notes";
      type = "int";
      min = 2;
      max = 5;
      default= 3;
      changed = function(x) nChordNotes = x end
    };
    { name = "Base note start";
      type = "int";
      min = 21;
      max = 108;
      default=36;
      changed = function(x) baseNoteStart = x end
    };
    { name = "Chord notes passthrough";
      type = "list";
      values = {false; true};
      default = false;
      changed = function(x) chordNotesPassthrough = x end
    };
    { name = "Root 5th";
      type = "list";
      values = {false; true};
      default = false;
      changed = function(x) root5 = x end
    };
}
