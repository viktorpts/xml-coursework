const levels = {
    0: 'Basic',
    1: 'Fundamentals',
    2: 'Advanced',
    3: 'Master'
};

function parse(data) {
    const doc = xmlBuilder('Course');
    doc.append(doc.e('Name', data.Name));
    if (data.Description) {
        doc.append(doc.e('Description', data.Description));
    }
    if (data.Category) {
        doc.append(doc.e('Category', data.Category));
    }
    if (data.Level !== undefined) {
        doc.append(doc.e('Level', levels[data.Level]));
    }
    doc.append(doc.e('Instance', [
        doc.e('StartDateTime', data.StartDateTime),
        doc.e('EndDateTime', data.EndDateTime)
    ]));
    doc.append(doc.e('Units', data.Units.map(u => {
        const content = [
            doc.e('Name', u.Name),
            doc.e('Instance', [
                doc.e('StartDateTime', u.StartDateTime),
                doc.e('EndDateTime', u.EndDateTime)
            ]),
            doc.e('Resources', u.Resources.map(r => {
                const content = [
                    doc.e('Name', r.Name),
                    doc.e('URL', r.URL)
                ];
                if (r.IconURL) {
                    content.push(doc.e('IconURL', r.IconURL));
                }
                const attrs = {
                    type: r.type,
                };
                if (r.order !== undefined) {
                    attrs.order = r.order;
                }
                if (r.visible !== undefined) {
                    attrs.visible = r.visible;
                }
                return doc.e('Resource', content, attrs);
            })),
        ];
        if (u.Description) {
            content.push(doc.e('Description', u.Description));
        }
        const attrs = u.order !== undefined ? { order: u.order } : null;
        return doc.e('Unit', content, attrs);
    })));
    doc.append(doc.e('Trainers', data.Trainers.map(t => {
        const content = [
            doc.e('FirstName', t.FirstName),
            doc.e('LastName', t.LastName),
        ];
        if (t.Description) {
            content.push(doc.e('Description', t.Description));
        }
        if (t.PhotoURL) {
            content.push(doc.e('PhotoURL', t.PhotoURL));
        }
        const attrs = t.public !== undefined ? { public: t.public } : null;
        return doc.e('Trainer', content, attrs);
    })));
    doc.append(doc.e('Students', data.Students.map(s => {
        const content = [
            doc.e('FirstName', s.FirstName),
            doc.e('LastName', s.LastName),
            doc.e('Email', s.Email),
        ];
        if (s.Score !== undefined) {
            content.push(doc.e('Score', s.Score));
        }
        return doc.e('Student', content);
    })));

    return(doc);
}

function xmlBuilder(rootName) {
    const doc = document.implementation.createDocument('', '', null);
    const root = doc.createElement(rootName);
    doc.appendChild(root);

    root.e = e;

    return root;

    function e(type, content, attributes) {
        const result = doc.createElement(type);

        if (attributes) {
            for (let attr of Object.keys(attributes)) {
                result.setAttribute(attr, attributes[attr]);
            }
        }

        result.append = (child) => {
            if (typeof (child) === 'string' || typeof (child) === 'number') {
                if (child.toString().trim()[0] === '<') {
                    result.innerHTML = `<![CDATA[${child}]]>`;
                } else {
                    child = document.createTextNode(child);
                    result.appendChild(child);
                }
            } else if (Array.isArray(child)) {
                for (let node of child) {
                    result.append(node);
                }
            } else {
                result.appendChild(child);
            }
            return result;
        };

        result.appendTo = (parent) => {
            parent.append(result);
            return result;
        };

        if (content !== undefined && content !== null) {
            result.append(content);
        }
        return result;
    };
}



function download(filename, data) {
    var blob = new Blob([data], { type: 'text/xml' });
    if (window.navigator.msSaveOrOpenBlob) {
        window.navigator.msSaveBlob(blob, filename);
    }
    else {
        var elem = window.document.createElement('a');
        elem.href = window.URL.createObjectURL(blob);
        elem.download = filename;
        document.body.appendChild(elem);
        elem.click();
        document.body.removeChild(elem);
    }
}