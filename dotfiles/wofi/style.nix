{colorscheme}:
with colorscheme.colors; let
in ''
* {
    all: unset;
    font-family: "NotoSansCJK:style=Bold";
    font-size: 32px;
    color: #ffffd8; /* Ensure text color consistency */
}

#window {
    background-color: rgba(1, 1, 1, 0);
    border-radius: 20px;
    border: 2px solid #aaaab0;
    box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.5); /* Subtle shadow for depth */
}

#outer-box {
    background-color: rgba(1, 1, 1, 0.85); /* Slightly opaque for a cleaner look */
    border: 2px solid #999999;
    border-radius: 20px; /* Fully rounded corners */
    box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.3); /* Depth for outer box */
    overflow: hidden; /* Ensures child elements don't stick out */
}

#scroll {
    border: 4px solid #ccc2ff;
    margin: 1rem;
    border-radius: 12px;
    background-color: #181b28;
    box-shadow: inset 0px 2px 6px rgba(0, 0, 0, 0.4); /* Inset shadow for scroll */
}

#input {
    margin: 1rem 8rem;
    border: 4px solid #ccc2ff;
    border-radius: 12px;
    padding: 0.5rem 1rem;
    background-color: #181b28;
    box-shadow: inset 0px 2px 6px rgba(0, 0, 0, 0.4); /* Slight inset for input */
    color: #ffffd8;
}

#entry {
    margin: 0.25rem 0.75rem;
    padding: 0.5rem 1rem; /* More padding for spacing */
    color: #ffffd8;
    background-color: rgba(255, 255, 255, 0.05); /* Light background for entries */
    border-radius: 12px; /* Fully rounded corners */
    transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transitions */
}

#entry:hover {
    background-color: #33334d; /* Subtle hover effect */
}

#entry:selected {
    color: #89fc00;
    font-weight: bold;
    background-color: #222238; /* Distinct selected entry background */
}

''


